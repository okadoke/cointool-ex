import '../util' as util
import { price_channel } from '../../js/socket'

export tag Psc

  def build
    # @calc_data = CalcData.new()
    @calc_data = {
      params: {
        capital: 0,
        capital_cur: 'btc',
        risk_pct: 1,
        entry: 0,
        entry_cur: 'usd',
        stop: 0,
        target: 0
      },
      def risk
        (stop_dist > 0) ? (stop_dist / this:params:entry) : 0
      def reward
        (target_dist > 0) ? (target_dist / this:params:entry) : 0
      def risk_ratio
        (this:params:risk_pct > 0) ? (this:params:risk_pct / 100.0) : 0
      def risk_value
        this:params:capital * risk_ratio
      def stop_dist
        Math.abs(this:params:stop - this:params:entry)
      def target_dist
        Math.abs(this:params:target - this:params:entry)
      def r
        util.fmt_currency((target_dist > 0) ? (target_dist / stop_dist) : 0)
      def position_size
        util.fmt_currency((stop_dist > 0) ? (risk_value / stop_dist) * this:params:entry : 0)
    }

  def setup
    let local_data = read_local_storage
    if local_data
      Object.assign(@calc_data:params, local_data)

  def oninput e
    write_local_storage @calc_data:params

  def render
    <self>
      <div.box>
        <div.level>
          <div.heading.center> "Bitmex Calculator"
        <div>
          <CapitalRow data=@calc_data>
          <InputRow label="Risk %" data=@calc_data key="risk_pct">
          <EntryRow data=@calc_data>
          <InputRow label="Stop Price" data=@calc_data key="stop">
          <InputRow label="Target Price" data=@calc_data key="target">
          <OutputRow label="Reward:Risk" value=@calc_data.r>
          <OutputRow label="Position Size" value=@calc_data.position_size>


  def read_local_storage
    let local_data = JSON.parse(window:localStorage.getItem('psc'))
    local_data

  def write_local_storage data
    window:localStorage.setItem('psc', JSON.stringify(data))

tag CapitalRow

  prop data
  prop currency

  def build
    @conversion = {
      btc: {
        btc: do
          @data:params:capital
        usd: do
          @data:params:capital * @btcInUsd
      },
      usd: {
        usd: do
          @data:params:capital
        btc: do
          @data:params:capital / @btcInUsd
      }
    }

  def request_price
    price_channel.push('get_price', {ticker: 'BTC/USD'})
    setTimeout(&, 100000) do request_price

  def setup
    price_channel.on('BTC/USD', do |payload|
      @btcInUsd = payload:price
      Imba.commit()
    )
    # udpate price every 5s
    # initiate the price request loop
    request_price
  
  def btcValue
    @conversion[@data:params:capital_cur]:btc()

  def usdValue
    @conversion[@data:params:capital_cur]:usd()
      
  def render
    <self.field.is-horizontal>
      <div.field-label.is-small>
        <label.label> "Capital"
      <div.field-body>
        <div.field.is-narrow>
          <div.field.has-addons>
            <p.control>
              <span.select.is-small>
                <select[data:params:capital_cur]>
                  <option value='btc'> "BTC"
                  <option value='usd'> "USD"
                  <option value='eur'> "Eur"
            <p.control>
              <input[data:params:capital].input.is-small type="number" min="0">
          <div.help>
            <span> btcValue + " BTC" 
            <span css:float='right'> usdValue + " USD"

tag EntryRow

  prop data
      
  def render
    <self.field.is-horizontal>
      <div.field-label.is-small>
        <label.label> "Entry Price"
      <div.field-body>
        <div.field.is-narrow>
          <div.field.has-addons>
            <p.control>
              <span.select.is-small>
                <select[data:params:entry_cur]>
                  <option value='btc'> "BTC"
                  <option value='usd'> "USD"
                  <option value='eur'> "EUR"
            <p.control>
              <input[data:params:entry].input.is-small type="number" min="0">

tag InputRow

  prop label
  prop data
  prop key

  def render
    <self.field.is-horizontal>
      <div.field-label.is-small>
        <label.label> label
      <div.field-body>
        <div.field.is-narrow>
          <p.control>
            <input[data:params[key]].input.is-small type="number" min="0" step="0.1">

tag OutputRow
  prop label
  # prop data
  # prop key
  prop value

  def render
    <self.field.is-horizontal>
      <div.field-label.is-small>
        <label.label> label
      <div.field-body>
        <div.field.is-narrow>
          <div.control>
            <input.input.is-small value=value readOnly=true>

# class CalcData

#   prop capital 
#   prop risk_ratio
#   prop entry 
#   prop stop 
#   prop target 
#   prop r 
#   prop position_size

#   def initialize
#     @capital = 0
#     @risk_ratio = 0.1
#     @entry = 0
#     @stop = 0
#     @target = 0
#     @r = 0
#     @position_size = 0

#   def capital= value
#     let parsed = parseFloat(value)
#     @capital = isNaN(parsed) ? 0 : parsed
#     console.log("capital =", @capital)

#   def risk_ratio= value
#     @risk_ratio = value
#     console.log('risk_ratio:', value)

#   def position_size
#     let risk_value = @capital * @risk_ratio
#     let stop_dist = Math.abs(@stop - @entry)
#     @position_size = (stop_dist > 0) ? (stop_dist / risk_value) : 0