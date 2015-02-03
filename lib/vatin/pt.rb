
# Portugal specific
class PT < VATIN::Country
  def valid_id?
    @company_id.length == 9 && @company_id.int?
  end

  def vat
    ['PT', @company_id].join
  end

  def num
    [@company_id].join
  end
end
