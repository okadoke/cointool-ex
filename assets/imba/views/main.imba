import Psc from './psc'

export tag Main

  def render
    <self>
      <nav.navbar.is-white>
        <div.container>
          <div.navbar-brand>
            <a.navbar-item href="/"> 
              <div.title> "Cointool.io"
      <div.container>
        <div.columns>
          <aside.column.is-2.aside.is-fullheight.is-primary.has-shadow>
            <a.item href="/tools/psc"> "Position Size Calculator"
          <div.column>
            <Psc>
      