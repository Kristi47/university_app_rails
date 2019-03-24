class Student < ActiveRecord::Base

    EMAIL_FORMAT= /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    PASSWD_FORMAT= /\A.*(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).*\z/

    validates :email, uniqueness: true
    validates :firstname, :length => {:maximum => 30}, :presence => true
    validates :lastname, :length => {:maximum => 30}, :presence => true
    validates :email, :presence => true, :format => {:with => EMAIL_FORMAT , :message => "Not a valid email address"}
    validates :password, :presence => true, :length => {:minimum => 8}, :format => {:with => PASSWD_FORMAT, :message => "Password must have a minimum of 8 characters, must contain at least one uppercase letter, one lowercase letter, and one numerical character"}

    validate :firstnameLastnameLength
    validate :email_unique

    has_many :grades
    has_and_belongs_to_many :courses
    has_many :instructors, through: :courses

    def matches_password?(password)
        self.password == password
    end

    def email_unique
        if Instructor.exists?(:email => self.email) || Student.exists?(:email => self.email) 
            errors.add(:email, "This email address is taken, Please provide a new email address")
        end
    end

    def firstnameLastnameLength
        if ((self.firstname.length + self.lastname.length) > 50)
            errors.add(:firstname, "Firstname and lastname must not exceed 50 characters")
        end
    end
end
