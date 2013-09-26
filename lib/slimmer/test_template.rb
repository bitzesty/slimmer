module Slimmer::TestTemplate
  TEMPLATE = %q{
    <html>
      <head>
        <title>Test Template</title>
      </head>
      <body>
        <header id="global-header"></header>
        <div id="global-breadcrumb" class="header-context">
          <nav role="navigation">
            <ol class="group">
              <li><a href="/">Home</a></li>
            </ol>
          </nav>
        </div>

        <div id="wrapper"></div>

        <footer id="footer"></footer>

        <script src="https://static.preview.alphagov.co.uk/static/govuk-template.js" type="text/javascript"></script>
        <script src="https://static.preview.alphagov.co.uk/static/libs/jquery/jquery-1.7.2.min.js" type="text/javascript"></script>
        <script src="https://static.preview.alphagov.co.uk/static/application.js" type="text/javascript"></script>
      </body>
    </html>
  }
end
