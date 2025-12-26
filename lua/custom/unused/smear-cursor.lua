return {
    {
        'sphamba/smear-cursor.nvim',
        event = { 'CursorMoved', 'CursorMovedI' },
        opts = {
            -- Cursor movement smoothness (faster settings)
            stiffness = 0.95, -- How fast the smear's head moves towards target [0, 1]
            trailing_stiffness = 0.8, -- How fast the smear's tail follows [0, 1] - smoother tail
            damping = 0.7, -- Velocity reduction over time [0, 1] - lower = less braking

            -- Insert mode specific settings (faster)
            stiffness_insert_mode = 0.8, -- Faster head movement in insert mode
            trailing_stiffness_insert_mode = 0.6, -- Smoother tail movement in insert mode
            damping_insert_mode = 0.8, -- Lower damping in insert mode for faster movement

            -- Animation control
            distance_stop_animating = 0.1, -- Stop animation when close to target
            distance_stop_animating_vertical_bar = 0.875, -- Stop distance for vertical bar cursor

            -- Smear behavior
            smear_between_buffers = true, -- Smear when switching buffers
            smear_between_neighbor_lines = true, -- Smear between adjacent lines
            smear_insert_mode = true, -- Enable smear in insert mode

            -- Performance and visual settings
            time_interval = 17, -- Animation framerate (60fps)
            max_length = 25, -- Maximum smear length for better tail
            max_length_insert_mode = 8, -- Longer smear in insert mode

            -- Color and visual enhancements for better tail
            color_levels = 24, -- More color gradation levels for smoother tail
            gamma = 2.2, -- Color blending gamma for better tail colors
            gradient_exponent = 1.2, -- Enhanced longitudinal gradient for smoother tail fade
            trailing_exponent = 1.5, -- Smoother tail fade curve
            volume_reduction_exponent = 0.2, -- Less aggressive volume reduction for fuller tail
            minimum_volume_factor = 0.8, -- Higher minimum volume for more visible tail

            -- Enhanced legacy computing symbols for better visuals
            legacy_computing_symbols_support = false, -- Set to true if font supports block symbols
            use_diagonal_blocks = true, -- Better diagonal rendering

            -- Direction controls for smooth tracking
            smear_horizontally = true,
            smear_vertically = true,
            smear_diagonally = true,

            -- Cursor type detection
            vertical_bar_cursor_insert_mode = true -- Assumes vertical bar in insert mode
        }
    }
}