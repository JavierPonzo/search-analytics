# Only seed if no articles exist to prevent duplicates
if Article.count == 0
  Article.create([
    { title: 'What is Ruby on Rails?', content: 'A web framework written in Ruby that makes building web applications fast and fun.' },
    { title: 'How to make good coffee', content: 'Start with quality beans, grind them fresh, use the right water temperature (90-96°C), and brew for the optimal time.' },
    { title: 'What is a good car?', content: 'Depends on your needs... For city driving, consider fuel efficiency. For families, prioritize safety and space.' },
    { title: 'How is Emil Hajric doing?', content: 'Emil is doing well and continuing to inspire developers around the world!' },
    { title: 'Why is the sky blue?', content: 'Science explains it as light scattering through atmospheric particles, with blue wavelengths scattering more than others.' },
    { title: 'How to learn programming?', content: 'Start with a beginner-friendly language like Python or JavaScript. Practice daily, build projects, and join coding communities.' },
    { title: 'What is the best pizza topping?', content: 'While subjective, classics like margherita with fresh basil, mozzarella, and tomato sauce are universally loved.' },
    { title: 'How to stay motivated while coding?', content: 'Set small achievable goals, celebrate wins, take breaks, work on projects you care about, and connect with other developers.' },
    { title: 'What is artificial intelligence?', content: 'AI is computer technology that can perform tasks typically requiring human intelligence, like learning, reasoning, and problem-solving.' },
    { title: 'How to make the perfect pancakes?', content: 'Mix dry ingredients separately from wet ones, don\'t overmix the batter, let it rest, and cook on medium heat with butter.' },
    { title: 'What is the meaning of life?', content: 'According to Douglas Adams: 42. But philosophically, it\'s about finding purpose, connection, growth, and making a positive impact.' },
    { title: 'How to start exercising?', content: 'Begin with 10-15 minutes daily, choose activities you enjoy, set realistic goals, and gradually increase intensity.' },
    { title: 'What makes a good friend?', content: 'Loyalty, honesty, good listening skills, reliability, shared interests, and someone who supports your growth.' },
    { title: 'How to travel on a budget?', content: 'Book in advance, use budget airlines, stay in hostels, eat local food, use public transport, and travel during off-seasons.' },
    { title: 'What is the secret to happiness?', content: 'Research shows: gratitude, strong relationships, regular exercise, pursuing meaningful goals, and helping others contribute to happiness.' }
  ])
  
  puts "Created #{Article.count} articles!"
else
  puts "Articles already exist (#{Article.count} found). Skipping seed."
end
