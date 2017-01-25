module ListingsHelper

  # Returns the image associated with the name of listing
  def listing_image_for(listing_name, options = { size: 80 })
    listing_images = { "king_salmon"   => "king-salmon.jpg",
                       "black_cod"     => "black-cod.jpg",
                       "halibut"       => "halibut.png",
                       "spot_prawn"    => "spot-prawn.jpg" }
    listing_image_path = listing_images[listing_name]
    size = options[:size].to_s
    image_tag(listing_image_path, alt: listing_title_for(listing_name),
              size: size, class: "img-buffer img-rounded img-responsive")
  end

  def listing_title_for(listing_name)
    listing_titles = { "king_salmon" => "King Salmon",
                       "black_cod"   => "Black Cod",
                       "halibut"     => "Halibut",
                       "spot_prawn"  => "Spot Prawn" }
    listing_titles[listing_name]
  end
end
