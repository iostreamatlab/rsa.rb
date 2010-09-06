module RSA
  ##
  # Mathematical helper functions for RSA.
  module Math
    extend ::Math

    ##
    # Performs a primality test on the integer `n`, returning `true` if it
    # is a prime.
    #
    # @example
    #   1.upto(10).select { |n| RSA::Math.prime?(n) }  #=> [2, 3, 5, 7]
    #
    # @param  [Integer] n
    # @return [Boolean]
    # @see    http://en.wikipedia.org/wiki/Primality_test
    # @see    http://ruby-doc.org/core-1.9/classes/Prime.html
    def self.prime?(n)
      if n.respond_to?(:prime?)
        n.prime?
      else
        require 'prime' unless defined?(Prime) # Ruby 1.9+ only
        Prime.prime?(n)
      end
    end

    ##
    # Performs modular exponentiation in a memory-efficient manner.
    #
    # This is equivalent to `base**exponent % modulus` but much faster for
    # large exponents.
    #
    # This is presently a semi-naive implementation. Don't rely on it for
    # very large exponents.
    #
    # @example
    #   RSA::Math.modpow(5, 3, 13)                     #=> 8
    #   RSA::Math.modpow(4, 13, 497)                   #=> 445
    #
    # @param  [Integer] base
    # @param  [Integer] exponent
    # @param  [Integer] modulus
    # @return [Integer]
    # @see    http://en.wikipedia.org/wiki/Modular_exponentiation
    def self.modpow(base, exponent, modulus)
      1.upto(exponent).inject(1) do |c, e|
        (c * base) % modulus
      end
    end

    ##
    # Returns the Euler totient for the positive integer `n`.
    #
    # This is presently a very naive implementation. Don't rely on it for
    # anything but very small values of `n`.
    #
    # @example
    #   (1..5).map { |n| RSA::Math.phi(n) }            #=> [1, 1, 2, 2, 4]
    #
    # @param  [Integer] n
    # @return [Integer]
    # @see    http://en.wikipedia.org/wiki/Euler's_totient_function
    # @see    http://mathworld.wolfram.com/TotientFunction.html
    def self.phi(n)
      1 + (2...n).count { |i| i.gcd(n).eql?(1) }
    end

    ##
    # Returns the binary logarithm of `n`.
    #
    # @param  [Integer] n
    # @return [Float]
    # @see    http://en.wikipedia.org/wiki/Binary_logarithm
    def self.log2(n)
      ::Math.log2(n)
    end

    ##
    # Returns the base-256 logarithm of `n`.
    #
    # @param  [Integer] n
    # @return [Float]
    # @see    http://en.wikipedia.org/wiki/Logarithm
    def self.log256(n)
      ::Math.log(n, 256)
    end

    ##
    # Returns the natural logarithm of `n`. If the optional argument `b` is
    # given, it will be used as the base of the logarithm.
    #
    # @param  [Integer] n
    # @param  [Integer] b
    # @return [Float]
    # @see    http://en.wikipedia.org/wiki/Natural_logarithm
    def self.log(n, b = nil)
      b ? ::Math.log(n, b) : ::Math.log(n)
    end
  end
end
