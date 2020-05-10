{:ru =>
  { :i18n =>
    { :plural =>
      { :keys => [:one, :few, :other],
        :rule => lambda { |n|
          if n % 100 >= 11 && n % 100 <= 14
            :other
          elsif n % 10 == 1
            :one
          elsif (n % 10).between?(2,4)
            :few
          elsif (n % 10).between?(5,9)
            :other
          end
        }
      }
    }
  }
}
