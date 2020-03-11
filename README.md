# react-native-my-contacts

## Getting started

`$ npm install react-native-my-contacts --save`

or

`$ yarn add react-native-my-contacts`

### Mostly automatic installation

`$ react-native link react-native-my-contacts`

## Usage with Hooks
You need to import ContactProvider in order to use the hooks 
```javascript
//App.js or your entry node
import { ContactProvider } from 'react-native-my-contacts';

const App () => (
  <ContactProvider>
    <Root />
  </ContactProvider>
)

export default App
```

To use useContacts is pretty simple
```javascript
import { useContacts } from 'react-native-my-contacts';

const View = () => {

  const { contacts, loading, error, refetchContacts } = useContacts()

  return (
    <View />
  )
}
```

## Usage without Hooks
Just import the default from module, its promise based.

```javascript
import ContactManager from 'react-native-my-contacts';

const View = () => {

  useEffect(() => {
    async function fetchContacts() {
      try {
        const contacts = await ContactManager.getContacts()
      } catch (error) {
        //do something with error
      }
    }
  })

  return (
    <View />
  )
}
```

# Properties
**useContact()**

| Prop | Type | Description |
| ----------- | ----------- | ----------- |
| contacts | Array | An array with your contacts
| loading | Bool | An Boolean to indicate if contacts is fetching
| error | Object | An object with error information
| refetchContacts | Func | An Function to refetch contacts

# Error

The error object from hooks or async function have two props, code and message.
The message is in portuguese, in the fulture I will implemente some Internationalization, sorry =/

| Code | Message 
| ----------- | ----------- 
| UNAUTHORIZED | Você precisa autorizar o aplicativo para visualizar os contatos
| FAILED | Falha ao visualizar os contatos