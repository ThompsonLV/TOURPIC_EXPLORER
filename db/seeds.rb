Monument.destroy_all
Question.destroy_all
Answer.destroy_all
User.destroy_all
UserMonument.destroy_all

canuts = Monument.create!(
  title: "Mur des Canuts",
  short_description: "Située dans le quartier de la Croix-Rousse, cette fresque en trompe l'œil",

  long_description: " Le Mur des canuts y représente un grand nombre de ses habitants.
  Il est dédié aux canuts, des ouvriers tisserands de soie.Après l'avoir contemplé,
    partez à la découverte de ce quartier historique qui surplombe Lyon.",
  points: 500,

  address: "36 Bd des Canuts, 69004 Lyon"
)

antique = Monument.create!(
  title:"Théâtre antique de Lugdunum",
  short_description: "Il est adossé à la colline de Fourvière, en dessous de son sommet",
  long_description: "Abandonné à la fin de l'Empire romain,
    il est transformé en carrière et fortement endommagé puis,
    complètement enseveli au Moyen Âge, il tombe dans l'oubli.
    Il est repéré par hasard à la fin du xixe siècle,
    puis entièrement dégagé et restauré à partir de 1933.
      Il forme avec ses voisins l'Odéon antique.",
  points: 600,
  address: " 17 Rue Cleberg, 69005 Lyon"
)

bellecour = Monument.create!(
  title: "Place Bellecour",
  short_description: "Élément majeur de la ville et sa plus grande place avec ses 62 000 m2",
  long_description: "Le mot « Bellecour », nom actuel de la place, apparaît dès le XIIe siècle.
    Les terres agricoles que l'archevêque y possède sont appelées beau jardin. Au XVIe siècle,
    ce qui n'est encore qu'un pâturage porte le nom de pré de « Belle court ».",
  points: 400,
  address: "Pl. Bellecour, 69002 Lyon")

p "Etape 1"
questions1 = Question.create!(content: "Quand a eu lieu la révolte des Canuts", monument: canuts)
answers1 = Answer.create!(content: "24 janvier 1906", question: questions1, success: false)
answers2 = Answer.create!(content: "22 novembre 1831", question: questions1, success: true)
answers3 = Answer.create!(content: "4 septembre 1789", question: questions1, success: false)
p "Etape 2"

questions2 = Question.create!(content: "En quelle année le théâtre a t-il été réstauré ?", monument: antique)
answers1 = Answer.create!(content: "1933", question: questions2, success: true)
answers2 = Answer.create!(content: "1948", question: questions2, success: false)
answers3 = Answer.create!(content: "1600", question: questions2, success: false)
p "Etape 3"

questions3 = Question.create!(content: "Qui est sur le cheval de Bellecour", monument: bellecour)
answers1 = Answer.create!(content: "Louis XIV", question: questions3, success: true)
answers2 = Answer.create!(content: "Napoléon", question: questions3, success: false)
answers3 = Answer.create!(content: "Vercingétorix", question: questions3, success: false)
p "Etape 4"

questions4 = Question.create!(content: "Comment est le trompe l'oeil", monument: canuts)
answers1 = Answer.create!(content: "Super", question: questions4, success: true)
answers2 = Answer.create!(content: "Top", question: questions4, success: false)
answers3 = Answer.create!(content: "ça va", question: questions4, success: false)
p "Finis ! "

@thomas = User.create!(email: "thomas@gmail.com", first_name: "Thomas", last_name: "Leveo", password: 'azerty', password_confirmation: 'azerty')
@charles = User.create!(email: "charles@gmail.com", first_name: "Charles", last_name: "DeMont", password: 'azerty', password_confirmation: 'azerty')
@lazari = User.create!(email: "lazari@gmail.com", first_name: "lazari", last_name: "Kacimi", password: 'azerty', password_confirmation: 'azerty')
p "Non pas encore"
fav1 = UserMonument.create!(user: @thomas, monument: bellecour, favoris: false)
fav2 = UserMonument.create!(user: @charles,monument: canuts, favoris: true)
fav3 = UserMonument.create!(user: @lazari, monument: antique, favoris: true)
p "Vraiment finis"
