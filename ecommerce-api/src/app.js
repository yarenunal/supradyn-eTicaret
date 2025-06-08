const express = require('express');
const cors = require('cors');
require('dotenv').config();

const sequelize = require('./config/database');
const authRoutes = require('./routes/auth.routes');

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use('/api/auth', authRoutes);

// Database connection and sync
sequelize.sync()
    .then(() => {
        console.log('Database connected and synced');
    })
    .catch((err) => {
        console.error('Database connection error:', err);
    });

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
