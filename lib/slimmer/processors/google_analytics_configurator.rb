require "json"

module Slimmer::Processors
  class GoogleAnalyticsConfigurator
    PAGE_LEVEL_EVENT = 3

    def initialize(response, artefact)
      @headers = response.headers
      @artefact = artefact
    end

    def filter(src, dest)
      custom_vars = []
      if @artefact
        custom_vars << set_custom_var_downcase(1, "Section", @artefact.primary_root_section["title"]) if @artefact.primary_root_section
        custom_vars << set_multivalue_custom_var(3, "NeedID", @artefact.need_ids)
        custom_vars << set_custom_var_downcase(4, "Proposition", (@artefact.business_proposition ? 'business' : 'citizen')) unless @artefact.business_proposition.nil?
      end
      custom_vars << set_custom_var(9, "Organisations", @headers[Slimmer::Headers::ORGANISATIONS_HEADER])
      custom_vars << set_custom_var(10, "WorldLocations", @headers[Slimmer::Headers::WORLD_LOCATIONS_HEADER])
      custom_vars << set_custom_var_downcase(2, "Format", @headers[Slimmer::Headers::FORMAT_HEADER])
      custom_vars << set_custom_var_downcase(5, "ResultCount", @headers[Slimmer::Headers::RESULT_COUNT_HEADER])

      if dest.at_css("#ga-params")
        dest.at_css("#ga-params").content += custom_vars.compact.join("\n")
      end
    end

  private
    def set_custom_var_downcase(slot, name, value)
      return nil unless value
      set_custom_var(slot, name, value.downcase)
    end

    def set_multivalue_custom_var(slot, name, values)
      return nil if !values.is_a?(Array) || values.empty?
      set_custom_var(slot, name, values.join(',').downcase)
    end

    def set_custom_var(slot, name, value)
      return nil unless value
      response = "_gaq.push(#{JSON.dump([ "_setCustomVar", slot, name, value, PAGE_LEVEL_EVENT])});\n"
      response + "GOVUK.Analytics.#{name} = \"#{value}\";"
    end
  end
end

