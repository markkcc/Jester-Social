namespace :profile_pics do
  desc "Generate placeholder profile pictures"
  task generate: :environment do
    colors = [
      '#FF6B6B', # Coral Red
      '#4ECDC4', # Turquoise
      '#45B7D1', # Sky Blue
      '#96CEB4', # Sage Green
      '#FFEEAD', # Cream
      '#D4A5A5', # Dusty Rose
      '#9B59B6', # Purple
      '#3498DB', # Blue
      '#E67E22'  # Orange
    ]

    colors.each_with_index do |color, index|
      svg_content = <<~SVG
        <?xml version="1.0" encoding="UTF-8"?>
        <svg width="200" height="200" viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg">
          <rect width="200" height="200" fill="#{color}"/>
          <circle cx="100" cy="80" r="40" fill="#FFFFFF" opacity="0.2"/>
          <path d="M100 140 Q 140 180 180 140" stroke="#FFFFFF" stroke-width="8" fill="none" opacity="0.2"/>
        </svg>
      SVG

      File.write(Rails.root.join('public', 'images', 'profile_pics', "profile_#{index + 1}.svg"), svg_content)
    end
  end
end 