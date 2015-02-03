
# Helper added.
# Maybe inject this into VATIN::Country instead?
class String
  def int?
    /\A[-+]?\d+\z/ === self
  end
end

#
module VATIN
  VERSION = '0.0.1'

  # List of supported countries
  SUPPORTED_COUNTRIES = %w(fr pt)

  # User-facing service to validate VAT number
  # and get additional info about business entity
  VIES_URL = 'http://ec.europa.eu/taxation_customs/vies/viesquer.do?ms=%s&vat=%s'

  #
  # @param [String] country
  # @param [String] company_id
  #
  # @return [Hash]
  #
  def self.get(country, company_id)
    company_id = company_id.delete ' '
    co = Kernel.const_get(country.upcase).new(company_id)

    # TODO: bg check against VIES + tag response with result

    {
      company_id: company_id,
      vat: co.vat,
      validate_url: format(VIES_URL, co.country, co.num)
    }
  end

  #
  class Country
    def initialize(company_id)
      @company_id = company_id
      raise ArgumentError.new('Not a valid company id.') unless valid_id?
    end

    # return the country id
    def country
      self.class.name
    end

    # return the numeric part, after country prefix
    # make sure to override it
    def num; 0; end

    # return whether the given company id is valid
    # make sure to override it
    def valid_id?; false; end

    # return whether the provided VAT IN has a valid format for this country.
    # make sure to override it
    def valid_vat_format?(vat); false; end

    # return found VAT IN
    # make sure to override it
    def vat; nil; end

    # TODO: make expectations methods (type, length, etc.)
  end

end

require 'vatin/fr'
require 'vatin/pt'
