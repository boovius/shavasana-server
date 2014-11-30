web: bundle exec thin -R config.ru start -p $PORT -e $RACK_ENV
counts_worker: QUEUE=counts bundle exec rake resque:work
