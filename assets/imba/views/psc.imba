export tag Psc

  def build
    @calc_data = CalcData.new()

  def render
    <self>
      <div.box>
        <div.level>
          <div.heading.center> "Bitmex Calculator"
        <div>
          <CapitalRow data=@calc_data>
          <InputRow label="Risk %" data=@calc_data key="risk_ratio">
          <InputRow label="Entry Price" data=@calc_data key="entry">
          <InputRow label="Stop Price" data=@calc_data key="stop">
          <InputRow label="Target Price" data=@calc_data key="target">
          <OutputRow label="Reward:Risk" data=@calc_data key="r">
          <OutputRow label="Position Size" data=@calc_data key="position_size">

tag CapitalRow

  prop data
  
  def render
    <self.field.is-horizontal>
      <div.field-label.is-small>
        <label.label> "Capital"
      <div.field-body>
        <div.field.has-addons>
          <p.control>
            <span.select.is-small>
              <select>
                <option> "BTC"
                <option> "$"
                <option> "Eur"
          <p.control>
            <input[data.capital].input.is-small type="text">

tag InputRow

  prop label
  prop data
  prop key

  def value
    data[key]()

  def value= val
    data[key](val)
    console.log('data:', data)

  def render
    <self.field.is-horizontal>
      <div.field-label.is-small>
        <label.label> label
      <div.field-body>
        <div.field.is-expanded>
          <p.control>
            <input[value].input.is-small type="text">

tag OutputRow
  prop label
  prop data
  prop key

  def render
    <self.field.is-horizontal>
      <div.field-label.is-small>
        <label.label> label
      <div.field-body>
        <div.field>
          <div.control>
            <input.input.is-small value=data[key]() readOnly=true>

class CalcData

  prop capital 
  prop risk_ratio
  prop entry 
  prop stop 
  prop target 
  prop r 
  prop position_size

  def initialize
    @capital = 0
    @risk_ratio = 0.1
    @entry = 0
    @stop = 0
    @target = 0
    @r = 0
    @position_size = 0

  def capital= value
    let parsed = parseFloat(value)
    @capital = isNaN(parsed) ? 0 : parsed
    console.log("capital =", @capital)

  def risk_ratio= value
    @risk_ratio = value
    console.log('risk_ratio:', value)

  def position_size
    let risk_value = @capital * @risk_ratio
    let stop_dist = Math.abs(@stop - @entry)
    @position_size = (stop_dist > 0) ? (stop_dist / risk_value) : 0