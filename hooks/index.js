import { useContext, useState, useEffect } from 'react'
import { NativeModules } from 'react-native'
import { ContactContext } from '../providers/contactProvider'

export default () => {
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const { contacts, setContacts } = useContext(ContactContext)

  const getContacts = async () => {
    setError('')
    setLoading(true)
    try {
      const resp = await NativeModules.ContactManager.getContacts()
      setContacts(resp)
    } catch (err) {
      if (err.code === 'UNAUTHORIZED') {
        err.message = 'Você precisa autorizar o aplicativo para visualizar os contatos'
      } else {
        err.message = 'Falha ao visualizar os contatos'
      }
      setError(err)
    } finally {
      setLoading(false)
    }
  }

  const refetchContacts = () => {
    getContacts()
  }

  useEffect(() => {
    getContacts()
  }, [])

  return {
    loading,
    error,
    contacts,
    refetchContacts,
  }
}
