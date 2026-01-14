module Jekyll
  class RedirectGenerator < Generator
    safe true
    priority :low

    def generate(site)
      return unless site.data['redirects']

      site.data['redirects'].each do |entry|
        from_path = entry['from']
        to_path = entry['to']

        # Create a virtual page
        # We use strict path for the source
        
        # Ensure path starts with /
        from_path = "/#{from_path}" unless from_path.start_with?('/')
        
        # Add trailing slash if no extension to ensure it renders as an index.html file
        # effectively making it a directory. This fixes the "file download" issue.
        permalink = from_path
        if File.extname(from_path).empty? && !permalink.end_with?('/')
          permalink += "/"
        end
        
        # Create the page
        page = PageWithoutAFile.new(site, site.source, "", from_path)
        page.content = ""
        page.data['layout'] = nil
        page.data['sitemap'] = false
        page.data['permalink'] = permalink
        page.data['redirect_to'] = to_path
        
        site.pages << page
      end
    end
  end
end
