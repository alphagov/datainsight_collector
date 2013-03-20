require "tzinfo"

class DateTime
  def to_local_timezone
    offset = TZInfo::Timezone.get("Europe/London").period_for_utc(self).utc_total_offset_rational
    (self - offset).new_offset(offset)
  end
end