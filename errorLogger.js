export function setupErrorLogger(logElementId = 'errorLog') {
    const errorLog = document.getElementById(logElementId);
    if (!errorLog) {
        console.error(`Error logger setup failed: Element with id '${logElementId}' not found.`);
        return;
    }

    function logError(message) {
        const errorItem = document.createElement('div');
        errorItem.textContent = message;
        errorLog.appendChild(errorItem);
    }

    window.onerror = function (message, source, lineno, colno, error) {
        const errorMessage = `Error: ${message} at ${source}:${lineno}:${colno}`;
        logError(errorMessage);
        console.error(errorMessage);
    };

    console.log(`Error logger initialized on element: #${logElementId}`);
}
