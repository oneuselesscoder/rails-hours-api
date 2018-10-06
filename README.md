# README

* API backend to hold time availability

* To run

  * rails s

* Basic endpoints examples
  * http POST :3000/users user_name=user

  * http POST :3000/users/1/hours starts='2018-10-07 10:31 am' ends='2018-10-07 02:00 pm'

  * http POST :3000/users/1/hours starts='2018-10-06 02:31:21.598312' ends='2018-10-06 22:30:22.598312'

    Or in heroku

  * http POST https://uselesscoder.herokuapp.com/users user_name=user


