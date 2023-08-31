require "json"
require "open-uri"

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
    new_monument = Monument.create!(
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
  short_description: "Située dans le quartier de la Croix-Rousse",
  long_description: "Le Wagon accueille depuis plusieurs années des étudiants",
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

p "Création des comptes"
p '------------------------'
@thomas = User.create!(email: "thomas@gmail.com", first_name: "Thomas", last_name: "Leveo", password: 'azerty', password_confirmation: 'azerty')
@charles = User.create!(email: "charles@gmail.com", first_name: "Charles", last_name: "DeMont", password: 'azerty', password_confirmation: 'azerty')
@lazari = User.create!(email: "lazari@gmail.com", first_name: "lazari", last_name: "Kacimi", password: 'azerty', password_confirmation: 'azerty')

p "Création des favoris"
p '------------------------'
UserMonument.create!(user: @thomas, monument: le_wagon, favoris: true)
UserMonument.create!(user: @charles,monument: le_wagon, favoris: true)
UserMonument.create!(user: @lazari, monument: le_wagon, favoris: true)

p "Terminé"
p '------------------------'
