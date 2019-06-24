import React from 'react';
import { NavLink } from 'react-router-dom';

import classes from './NavigationItem.css';

const navigationItem = (props) => {
    if(props.dropdown) {
        return (
            <li className={classes.NavigationItem}>
                <div className={classes.dropdown}>
                    <NavLink className={classes.dropdown} to={`${props.link}/${1}`}
                        activeClassName={classes.active}> {props.children} </NavLink>
                    <div className={classes.dropdownContent}>
                        <NavLink to={`${props.link}/${1}`} >Sokovi</NavLink>
                        <NavLink to={`${props.link}/${2}`} >Topli napici</NavLink>
                        <NavLink to={`${props.link}/${3}`} >Alkohol</NavLink>
                    </div>
                </div>
            </li>
        );
    } else { 
        return (
            <li className={classes.NavigationItem}>
                <NavLink to={props.link} exact={props.exact} activeClassName={classes.active}>{props.children}
                </NavLink>
            </li>
        );
    }
};

export default navigationItem;