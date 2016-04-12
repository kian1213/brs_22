namespace :db do
  def populate_image file_name
    File.open(File.join(Rails.root, "/app/assets/images/populate/#{file_name}"))
  end

  desc "Create dummy data"
  task populate: :environment do
    %w(db:populate_default_admin).each do |t|
      Rake::Task[t].invoke
      puts "Done populating. Please check your data."
    end
  end

  desc "Create Initial Admin"
  task populate_default_admin: :environment do
    user = User.new
    User.create(
      first_name: "John",
      last_name: "Doe",
      email: "admin@example.com",
      password: "admin123",
      admin: true,
      avatar: populate_image("default.jpg")
    )
  end
end
