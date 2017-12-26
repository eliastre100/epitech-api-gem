require 'epitech_api/providers'

user = EpitechApi::IntraProvider.auto_login 'auth-cb01ff8a7f60c846dbc8f1c4a7b3616f38b302ee'
# @type gatherer [Gatherer]
gatherer = user.gatherer

puts gatherer.promo_manager.extract_students(gatherer.promo_manager.get('tek1', 'FR/LIL', 2017)).first.inspect
