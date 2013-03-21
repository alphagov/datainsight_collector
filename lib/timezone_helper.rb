require "tzinfo"

class DateTime
  def with_tz_offset(region)
    offset = TZInfo::Timezone.get(region).period_for_utc(self).utc_total_offset_rational
    (self - offset).new_offset(offset)
  end
end