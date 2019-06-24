import React from 'react';

import NavigationItem from './NavigationItem/NavigationItem';
import classes from './NavigationItems.css';

const navigationItems = (props) => (
    <ul className={classes.NavigationItems}>
        <NavigationItem link="/items" exact dropdown="true">Proizvodi</NavigationItem>
        { props.isAuthenticated ? <NavigationItem link="/orders">Narudžbe</NavigationItem> : null }
        { !props.isAuthenticated ? 
        <NavigationItem link="/auth">Prijava/Registracija</NavigationItem> :
        <NavigationItem link="/logout">Odjava</NavigationItem> }
    </ul>
);

export default navigationItems;