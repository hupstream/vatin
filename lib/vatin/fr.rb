
# France specific
class FR < VATIN::Country
  # TODO: Luhn check
  def valid_id?
    @company_id.length == 9 && @company_id.int?
  end

  def key
    ((12 + 3 * (@company_id.to_i % 97)) % 97).to_s
  end

  def vat
    ['FR', key, @company_id].join
  end

  def num
    [key, @company_id].join
  end
end
