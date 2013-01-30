class Coffee < Struct.new(:id, :name)
  def to_hash
    { id: @id , name: @name }
  end
end
