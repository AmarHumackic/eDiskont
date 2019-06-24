import React from 'react';

import diskontLogo from '../../../assets/images/diskontlogo.jpg';
import classes from './Logo.css';

const logo = (props) => (
    <div className={classes.Logo}>
        <img src={diskontLogo} alt="Logo"></img>
    </div>
);

export default logo;
    