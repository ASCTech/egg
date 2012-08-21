Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.max_run_time = 2.minutes
Delayed::Worker.delay_jobs = !Rails.env.test?
