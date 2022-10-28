class User < ApplicationRecord

    attr_reader :password

    validates :username, :session_token, presence: true, uniqueness: true
    validates :password, allow_nil: true, length: {minimum: 6}
    validates :password_digest, presence: true
    
    before_validation :ensure_session_token
    #FIGVAPER

    def self.find_by_credentials(username, password)
        @user = User.find_by(username: username)
        if @user.is_password?(password) && @user
            @user
        else
            nil
        end
    end

    def generate_session_token
        SecureRandom::urlsafe_base64
    end

    def is_password?(password)
        password_object = BCrypt::Password.new(self.password_digest)
        password_object.is_password?(password)
    end

    def password=(password)
        @password = password
        self.password_digest = generate_session_token
    end

    def ensure_session_token
        self.session_token ||= generate_session_token 
    end

    def reset_session_token!
        self.session_token = generate_session_token 
        self.save!
        self.session_token
    end

end