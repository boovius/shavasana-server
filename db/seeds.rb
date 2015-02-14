User.delete_all
Activity.delete_all
Doing.delete_all

user = User.create(first_name: "Bosco", access_token: "20934872303059309485")

Activity.create([
  {title: 'yoga', user: user},
  {title: 'meditation', user: user}
])

Doing.create(activity: Activity.first)
Doing.create(activity: Activity.first)
Doing.create(activity: Activity.first)
Doing.create(activity: Activity.first)
Doing.create(activity: Activity.first)
Doing.create(activity: Activity.second)
Doing.create(activity: Activity.second)
