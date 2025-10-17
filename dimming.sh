#!/bin/bash
# Script to toggle the global Hyprland setting decoration:dim_inactive.

# 1. Read the current integer value of the setting (0 for false, 1 for true).
# The output is filtered using 'grep' and 'awk' to get only the numeric state.
# We use 'jq' with the JSON output for robustness if available, otherwise fall back to awk.
if command -v jq &> /dev/null; then
    CURRENT_STATE=$(hyprctl getoption decoration:dim_inactive -j | jq '.int')
else
    CURRENT_STATE=$(hyprctl getoption decoration:dim_inactive | grep 'int:' | awk '{print $2}')
fi

# 2. Determine the new state based on the current state.
if [ "$CURRENT_STATE" = "1" ]; then
    # If currently 1 (true), set the new state to false.
    NEW_STATE="false"
else
    # If currently 0 (false), set the new state to true.
    NEW_STATE="true"
fi

# 3. Apply the new state using hyprctl keyword.
hyprctl keyword decoration:dim_inactive "$NEW_STATE"
