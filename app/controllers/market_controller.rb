def index
  @listings = Listing.all.order("name ASC, price ASC")
end
