# Add a declarative step here for populating the DB with movies.
#[['Aladdin', 'G', '25-Nov-1992'], 
#  ['The Terminator', 'R', '26-Oct-1984'], 
#  ['When Harry Met Sally', 'R', '21-Jul-1989'], 
#  ['The Help', 'PG-13', '10-Aug-2011'],
#  ['Chocolat', 'PG-13', '5-Jan-2001'],
#  ['Amelie', 'R', '25-Apr-2001'],
#  ['2001: A Space Odyssey', 'G', '6-Apr-1968'],
#  ['The Incredibles', 'PG', '5-Nov-2004'],
#  ['Raiders of the Lost Ark', 'PG', '12-Jun-1981'],
#  ['Chicken Run', 'G', '21-Jun-2000']
#].each do |title, rating, release_date|
#  Movie.create!(:title => title, :rating => rating, 
#               :release_date => release_date)
#end

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  page.body.index(e1) < page.body.index(e2)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)$/ do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    if uncheck
      step "I uncheck 'ratings_#{rating}'"
    else
      step "I check 'ratings_#{rating}'"
    end
  end
end

Then /^I should see (none|all) of the movies$/ do |quantifier|
  rows = page.all('#movielist > tr').count
  if quantifier == "none"
    rows.should == 0
  elsif quantifier == "all"
    rows.should == 10
  end
end
