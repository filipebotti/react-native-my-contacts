import React, { useState } from 'react'
import PropTypes from 'prop-types'

export const ContactContext = React.createContext(null)
export const ContactProvider = ({ children }) => {
  const [contacts, setContacts] = useState([])

  return (
    <ContactContext.Provider value={{ contacts, setContacts }}>
      {children}
    </ContactContext.Provider>
  )
}

ContactProvider.propTypes = {
  children: PropTypes.object,
}

ContactProvider.defaultProps = {
  children: [],
}
