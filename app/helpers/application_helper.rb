module ApplicationHelper

    def base_title(title="")
        base_title ="Bidding System"
        if title.empty?
            base_title
        else 
            "#{title} | #{base_title}"
        end
    end
end
