struct Myhtml::Node
  #
  # Css selector with string rule in scope on the current_node
  #   return Myhtml::Iterator::Collection
  #
  # Example:
  #   node.css("div.red").each { |node| p node } # iterate over all divs with class `red` in the scope of node
  #
  def css(rule : String)
    filter = CssFilter.new(rule)
    css(filter)
  ensure
    filter.try &.free
  end

  #
  # Css selector with filter in scope on the current_node
  #   return Myhtml::Iterator::Collection
  #
  # Example:
  #   filter = Myhtml::CssFilter.new("div.red")
  #   node.css(filter).each { |node| p node } # iterator over all divs with class `red` in the scope of node
  #
  def css(filter : CssFilter)
    filter.search_from(self)
  end

  #
  # Css select which yielding collection
  #   this allows to free collection after block call and not waiting for GC
  #
  # Example:
  #   node.css("div.red") { |collection| collection.each { |node| p node } }
  #
  def css(arg)
    collection = css(arg)
    yield collection
  ensure
    collection.try &.free
  end
end
