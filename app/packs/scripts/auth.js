// Allows you to hide/show your password on log in / sign up
document.addEventListener('DOMContentLoaded', () => {
    const toggleButton = document.getElementById('toggle-password');
    const toggleConfirmationButton = document.getElementById('toggle-password-confirmation');
    const passwordField = document.getElementById('password-field');
    const passwordConfirmationField = document.getElementById('password-confirmation-field');

    if (toggleButton && passwordField) {
        toggleButton.addEventListener('click', (e) => {
            const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordField.setAttribute('type', type);
            e.target.classList.toggle('bi-eye');
        });
}
    
    if (toggleConfirmationButton && passwordConfirmationField) {
        toggleConfirmationButton.addEventListener('click', (e) => {
            const type = passwordConfirmationField.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordConfirmationField.setAttribute('type', type);
            e.target.classList.toggle('bi-eye');
        });
    }
});
