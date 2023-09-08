require "json"
require "open-uri"
require 'faker'

p '------------------------'
p 'Destruction des données'
p '------------------------'
Monument.destroy_all
Question.destroy_all
Answer.destroy_all
User.destroy_all
UserMonument.destroy_all

p 'Construction des monuments'
p '------------------------'
url = "https://data.grandlyon.com/fr/datapusher/ws/rdata/apd_apidae.apdlieutourisme_latest/all.json?maxfeatures=-1&start=1"
monuments_serialized = URI.open(url).read
monuments = JSON.parse(monuments_serialized)
i = 1
monuments['values'].first(300).each do |monument|
  if monument['type'] == 'PATRIMOINE_CULTUREL' && monument['illustrations'] != nil
    p "Monument #{i}"
    new_monument = Monument.new(
      title: monument['nom'],
      short_description: monument['descrcourtfr'],
      long_description: monument['descrdetailfr'],
      points: 500,
      latitude: monument['lat'],
      longitude: monument['lon']
    )

    begin
      image_url = monument['illustrations'].first['url']
      image_data = URI.open(image_url).read
      new_monument.photo.attach(io: StringIO.new(image_data), filename: "theatre.jpeg", content_type: "image/jpeg")
      new_monument.save
    rescue OpenURI::HTTPError => e
      puts "Image URL is not valid or couldn't be fetched: #{e.message}"
    rescue StandardError => e
      puts "An error occurred: #{e.message}"
    end
    i += 1
  end
end
p '------------------------'
p 'Construction du Wagon'
p '------------------------'
le_wagon = Monument.create!(
  title: "Le Wagon",
  short_description: "Le Wagon Lyon : situé dans le quartier de Terreaux,
                    l'école de codage propose des formations de web développement.",
  long_description: "Le Wagon Lyon a été créé en 2016 et est situé dans le quartier
                    de Terreaux. C'est une école de codage qui propose des formations
                    en développement web et en Data Analytics, en format 2 ou 6 mois,
                    sur campus ou en ligne.",
  points: 500,
  address: "20 Rue des Capucins, 69001 Lyon"
)

file_path = Rails.root.join("app/assets/images/le-wagon.jpg")
le_wagon.photo.attach(io: File.open(file_path), filename: "le-wagon.jpg", content_type: "image/jpg")
le_wagon.save

questions1 = Question.create!(content: "Dans quel quartier se situe Le Wagon Lyon ?", monument: le_wagon)
Answer.create!(content: "Confluence", question: questions1, success: false)
Answer.create!(content: "Terreaux", question: questions1, success: true)
Answer.create!(content: "Part-dieu", question: questions1, success: false)

questions2 = Question.create!(content: "En quelle année a été crée Le Wagon Lyon?", monument: le_wagon)
Answer.create!(content: "2016", question: questions2, success: true)
Answer.create!(content: "2018", question: questions2, success: false)
Answer.create!(content: "2009", question: questions2, success: false)

questions3 = Question.create!(content: "Qui est le créateur du Wagon ?", monument: le_wagon)
Answer.create!(content: "Les frères Paillard", question: questions3, success: true)
Answer.create!(content: "Les jumeaux Gerdon", question: questions3, success: false)
Answer.create!(content: "Les cousins Fernillon", question: questions3, success: false)

p "Création des comptes"
p '------------------------'

teams_avatar = Cloudinary::Api.resources(type: 'upload', prefix: "teams_avatar")
avatar = Cloudinary::Api.resources(type: 'upload', prefix: "avatars")

@thomas = User.new(email: "thomas@gmail.com", first_name: "Thomas", last_name: "Le Véo", password: 'azerty', password_confirmation: 'azerty')
thomas_avatar = teams_avatar["resources"].find { |resource| resource["public_id"] == "teams_avatar/thomas" }
thomas_avatar_url = Cloudinary::Utils.cloudinary_url(thomas_avatar['public_id'], width: 300, height: 300, crop: 'fill')
image_data = URI.open(thomas_avatar_url).read
@thomas.photo.attach(io: StringIO.new(image_data), filename: "thomas.jpeg", content_type: "image/jpeg")
@thomas.save

@charles = User.new(email: "charles@gmail.com", first_name: "Charles", last_name: "DeMont", password: 'azerty', password_confirmation: 'azerty')
charles_avatar = teams_avatar["resources"].find { |resource| resource["public_id"] == "teams_avatar/charles" }
charles_avatar_url = Cloudinary::Utils.cloudinary_url(charles_avatar['public_id'], width: 300, height: 300, crop: 'fill')
image_data = URI.open(charles_avatar_url).read
@charles.photo.attach(io: StringIO.new(image_data), filename: "charles.jpeg", content_type: "image/jpeg")
@charles.save

@lazari = User.new(email: "lazari@gmail.com", first_name: "Lazari", last_name: "Kacimi", password: 'azerty', password_confirmation: 'azerty')
lazari_avatar = teams_avatar["resources"].find { |resource| resource["public_id"] == "teams_avatar/lazari" }
lazari_avatar_url = Cloudinary::Utils.cloudinary_url(lazari_avatar['public_id'], width: 300, height: 300, crop: 'fill')
image_data = URI.open(lazari_avatar_url).read
@lazari.photo.attach(io: StringIO.new(image_data), filename: "lazari.jpeg", content_type: "image/jpeg")
@lazari.save

5.times do
  new_user = User.new(
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: 'azerty',
    password_confirmation: 'azerty'
  )
  random_avatar = avatar["resources"].sample
  random_avatar_url = Cloudinary::Utils.cloudinary_url(random_avatar['public_id'], width: 300, height: 300, crop: 'fill')
  image_data = URI.open(random_avatar_url).read
  new_user.photo.attach(io: StringIO.new(image_data), filename: "theatre.jpeg", content_type: "image/jpeg")
  new_user.save
end


p "Création des UserMonument "
p '------------------------'

users = User.all
monuments = Monument.all

a = 1
users.each do |user|
  p "User #{a}"
  (1..10).to_a.sample.times do

    random_monument = monuments.sample
    new_user_monument = UserMonument.create!(user: user, monument: random_monument, favoris: false)

    images = Cloudinary::Api.resources(type: 'upload', prefix: "monuments/")
    random_image = images["resources"].sample
    random_image_url = Cloudinary::Utils.cloudinary_url(random_image['public_id'])
    image_data = URI.open(random_image_url).read
    new_user_monument.photos.attach(io: StringIO.new(image_data), filename: "theatre.jpeg", content_type: "image/jpeg")
    new_user_monument.save
  end
  user.score = UserMonument.where(user_id: user.id).count * 500
  user.save
  a += 1
end

p '------------------------'
p "Terminé"
p '------------------------'
