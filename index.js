import { NativeModules } from 'react-native';

const { MyContacts } = NativeModules;

// export default {
//   hasPermission: () => MyContacts.hasPermission(result => result),
//   getContacts: async() => {
//     const contacts = await MyContacts.getContacts()
//     return contacts
//   }
// };

export default MyContacts;
