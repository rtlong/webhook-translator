module Status
  def health_status
    { boot_time: BOOT_TIME.to_s }
  end
end

