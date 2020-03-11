import React from 'react'
import { NativeModules } from 'react-native';
import useContacts from './hooks'
import { ContactProvider } from './provider'
const { ContactManager } = NativeModules;

export { ContactProvider, useContacts }
export default ContactManager;
