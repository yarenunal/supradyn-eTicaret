const jwt = require('jsonwebtoken');
const User = require('../models/user.model');

const signToken = (id) => {
    return jwt.sign({ id }, process.env.JWT_SECRET, {
        expiresIn: process.env.JWT_EXPIRES_IN
    });
};

exports.register = async (req, res) => {
    try {
        console.log('Gelen veri:', req.body);
        const { email, password, fullName } = req.body;

        // Check if user already exists
        const existingUser = await User.findOne({ where: { email } });
        if (existingUser) {
            return res.status(400).json({
                status: 'error',
                message: 'Email already in use'
            });
        }

        // Create new user
        const user = await User.create({
            email,
            password,
            fullName
        });

        // Generate token
        const token = signToken(user.id);

        res.status(201).json({
            status: 'success',
            token,
            data: {
                user: {
                    id: user.id,
                    email: user.email,
                    fullName: user.fullName
                }
            }
        });
    } catch (error) {
        res.status(400).json({
            status: 'error',
            message: error.message
        });
    }
};

exports.login = async (req, res) => {
    try {
        const { email, password } = req.body;

        // Check if email and password exist
        if (!email || !password) {
            return res.status(400).json({
                status: 'error',
                message: 'Please provide email and password'
            });
        }

        // Check if user exists && password is correct
        const user = await User.findOne({ where: { email } });
        if (!user || !(await user.correctPassword(password))) {
            return res.status(401).json({
                status: 'error',
                message: 'Incorrect email or password'
            });
        }

        // Generate token
        const token = signToken(user.id);

        res.status(200).json({
            status: 'success',
            token,
            data: {
                user: {
                    id: user.id,
                    email: user.email,
                    fullName: user.fullName
                }
            }
        });
    } catch (error) {
        res.status(400).json({
            status: 'error',
            message: error.message
        });
    }
}; 