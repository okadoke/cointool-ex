export tag Psc

  def build
    @calc_data = CalcData.new()

  def render
    <self>
      <div.box>
        <div.level>
          <div.heading.center> "Bitmex Calculator"
        <div>
          <CapitalRow calc_data=@calc_data>
          <InputRow label="Risk %">
          <InputRow label="Entry Price">
          <InputRow label="Stop Price">
          <InputRow label="Target Price">
          <OutputRow label="Reward:Risk">
          <OutputRow label="Position Size">

tag CapitalRow

  prop calc_data
  
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
            <input[@calc_data.capital].input.is-small type="text">

tag InputRow

  prop label
  prop data
  prop key

  def render
    <self.field.is-horizontal>
      <div.field-label.is-small>
        <label.label> label
      <div.field-body>
        <div.field.is-expanded>
          <p.control>
            <input.input.is-small type="text" value=0>

tag OutputRow
  prop label

  def render
    <self.field.is-horizontal>
      <div.field-label.is-small>
        <label.label> label
      <div.field-body>
        <div.field>
          <div.control>
            <input.input.is-small value=0 readOnly=true>

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

  def capital= value
    let parsed = parseFloat(value)
    @capital = parsed === NaN ? 0 : parsed
    console.log("capital =", @capital)