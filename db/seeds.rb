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
monuments['values'].first(100).each do |monument|
  if monument['type'] == 'PATRIMOINE_CULTUREL' && monument['illustrations'] != nil # && monument['address']['streetAddress'] && !monument["address"]["streetAddress"].start_with?("entre")
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
  short_description: "Le Wagon : école coding bootcamp renommée pour des
                    formations intensives en développement web et programmation.",
  long_description: "Le Wagon est une école de codage ou 'coding bootcamp'
                    qui propose des formations intensives en développement
                    web et en programmation informatique. Cette école est
                    présente dans de nombreuses villes à travers le monde
                    et offre des programmes de formation destinés à enseigner
                    les compétences en codage et en développement web en un laps
                    de temps relativement court, généralement de 9 à 24 semaines,
                    en fonction du programme choisi.",
  points: 500,
  address: "20 Rue des Capucins, 69001 Lyon"
)

file_path = Rails.root.join("app/assets/images/le-wagon.jpg")
le_wagon.photo.attach(io: File.open(file_path), filename: "le-wagon.jpg", content_type: "image/jpg")
le_wagon.save

questions1 = Question.create!(content: "Dans quel quartier se situe Le Wagon Lyon ?", monument: le_wagon)
Answer.create!(content: "Confluence", question: questions1, success: false)
Answer.create!(content: "Croix-rousse", question: questions1, success: true)
Answer.create!(content: "Part-dieu", question: questions1, success: false)

questions2 = Question.create!(content: "En quelle année a été crée Le Wagon ?", monument: le_wagon)
Answer.create!(content: "2013", question: questions2, success: true)
Answer.create!(content: "2018", question: questions2, success: false)
Answer.create!(content: "2009", question: questions2, success: false)

questions3 = Question.create!(content: "Qui est le créateur du Wagon ?", monument: le_wagon)
Answer.create!(content: "Les frères Paillard", question: questions3, success: true)
Answer.create!(content: "Les jumeaux Gerdon", question: questions3, success: false)
Answer.create!(content: "Les cousins Fernillon", question: questions3, success: false)

Monument.create!(
  title: "Maison Thomas",
  short_description: "Le Wagon : école coding bootcamp renommée pour des
                    formations intensives en développement web et programmation.",
  long_description: "Le Wagon est une école de codage ou 'coding bootcamp'
                    qui propose des formations intensives en développement
                    web et en programmation informatique.",
  points: 500,
  address: "175 cours Lafayette, 69006 Lyon"
)

p "Création des comptes"
p '------------------------'
@thomas = User.create!(email: "thomas@gmail.com", first_name: "Thomas", last_name: "Leveo", password: 'azerty', password_confirmation: 'azerty')
@charles = User.create!(email: "charles@gmail.com", first_name: "Charles", last_name: "DeMont", password: 'azerty', password_confirmation: 'azerty')
@lazari = User.create!(email: "lazari@gmail.com", first_name: "Lazari", last_name: "Kacimi", password: 'azerty', password_confirmation: 'azerty')

10.times do
  User.create!(
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: 'azerty',
    password_confirmation: 'azerty'
  )
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
    new_user_monument = UserMonument.create!(user: user, monument: random_monument, favoris: true)

    image_url = "https://www.google.com/url?sa=i&url=https%3A%2F%2Fnavaway.fr%2Fvisiter-lyon%2Fquartier-croix-rousse-lyon%2F&psig=AOvVaw1JESzInYIgv4RihepIp7uS&ust=1694032944265000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCLDGqtGqlIEDFQAAAAAdAAAAABAE"
    image_data = URI.open(image_url).read
    new_user_monument.photos.attach(io: StringIO.new(image_data), filename: "theatre.jpeg", content_type: "image/jpeg")
    new_user_monument.save
  end
  a += 1
end

UserMonument.create!(user: @charles, monument: le_wagon, favoris: true)
UserMonument.create!(user: @lazari, monument: le_wagon, favoris: true)

p "Terminé"
p '------------------------'
