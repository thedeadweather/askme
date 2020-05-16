require 'openssl'

class User < ApplicationRecord
  # Параметры работы для модуля шифрования паролей
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  USERNAME_REGEX = /\A[\w\d\_]*\z/i

  # виртуальный аттрибут
  attr_accessor :password

  has_many :questions, dependent: :destroy

  validates :email, :username, presence: true, uniqueness: true
  # проверка формата почты
  validates :email, format: { with: EMAIL_REGEX }
  # проверка на макс длину в 40 символов, проверка на уникальность без учета регистра букв, проверка на формат
  validates :username, length: { maximum: 40 }, format: { with: USERNAME_REGEX }
  # сохранять в БД почту и имя в нижнем регистре
  validates :password, confirmation: true, presence: true, on: :create
  validates :password_confirmation, presence: true

  before_save :encrypt_password
  before_validation :downcase_letters!

  scope :sorted, -> { order :created_at }

  # Служебный метод, преобразующий бинарную строку в 16-ричный формат,
  # для удобства хранения.
  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  # Основной метод для аутентификации юзера (логина). Проверяет email и пароль,
  # если пользователь с такой комбинацией есть в базе возвращает этого
  # пользователя. Если нету — возвращает nil.
  def self.authenticate(email, password)
    # Сперва находим кандидата по email
    user = find_by(email: email)
    # Если пользователь не найдет, возвращаем nil
    return nil unless user.present?
    # Формируем хэш пароля из того, что передали в метод
    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )
    # Сравнивается password_hash, а оригинальный пароль так
    # никогда и не сохраняется нигде.
    # Если пароли совпали, возвращаем пользователя.
    return user if user.password_hash == hashed_password
    # Иначе, возвращаем nil
    nil
  end

  private

  def downcase_letters!
    self.username&.downcase!
    self.email&.downcase!
  end

  def encrypt_password
    if password.present?
      # Создаем «соль» — рандомная строка усложняющая задачу по взлому
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))
      # Создаем хэш пароля — длинная уникальная строка, из которой невозможно
      # восстановить исходный пароль. Однако, если правильный пароль у нас есть,
      # мы легко можем получить такую же строку и сравнить её с той, что в базе.
      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
          password, password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
      )
      # Оба поля окажутся записанными в базу при сохранении.
    end
  end
end
