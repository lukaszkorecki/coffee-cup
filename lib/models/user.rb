class User < Struct.new(:id, :name)
  def to_hash
    { id: @id, name: @name }
  end
end
