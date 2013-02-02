class String
  def camelize
    split(nil).map!(&:capitalize).join
  end
end