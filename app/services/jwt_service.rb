class JwtService
  def decode(token)
    JWT.decode(token, ENV["JWT_SECRET_KEY"])
  end

  def encode(payload)
    puts payload

    JWT.encode(payload, ENV["JWT_SECRET_KEY"])
  end
end
