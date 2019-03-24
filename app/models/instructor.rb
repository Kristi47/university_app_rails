class Instructor < ActiveRecord::Base

    EMAIL_FORMAT= /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    PASSWD_FORMAT= /\A.*(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).*\z/

    validates_uniqueness_of :email
    validates :firstname, :length => {:maximum => 30}, :presence => true
    validates :lastname, :length => {:maximum => 30}, :presence => true
    validates :email, :presence => true, :format => {:with => EMAIL_FORMAT , :message => "Not a valid email address"}
    validates :password, :presence => true, :length => {:minimum => 8}, :format => {:with => PASSWD_FORMAT, :message => " must have a minimum of 8 characters, must contain at least one uppercase letter, one lowercase letter, and one numerical character"}
    
    validate :firstnameLastnameLength
    validate :email_unique

    has_many :courses
    has_many :students, through: :courses
    
    def matches_password?(password)
        self.password == password
    end

    def email_unique
        if Instructor.exists?(:email => email) && Student.exists?(:email => email) 
            errors.add(:email, "address is taken, Please provide a new email address")
        end
    end

    def firstnameLastnameLength
        if firstname.length + lastname.length > 50
            errors.add(:firstname, " and lastname must not exceed 50 characters")
        end
    end
end
