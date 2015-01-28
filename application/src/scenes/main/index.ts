import Aggregator = require('./aggregator');
import subscriber = require('./subscriber');

export = Main;
import defs = require('./defs')
class Main extends Overworld.Context<defs.Props, defs.State> {
  static component = require('../../components/main');
  static aggregator = new Aggregator;
  static subscriber = subscriber;
}
