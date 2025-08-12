document.addEventListener('turbo:load', () => {
  const addButton = document.getElementById('add-question');
  const questionsDiv = document.getElementById('questions');
  const templateElement = document.getElementById('question-template');

  if (!addButton || !questionsDiv || !templateElement) return;

  const template = templateElement.innerHTML;

  addButton.addEventListener('click', () => {
    const newId = new Date().getTime();
    const regexp = new RegExp('new_questions', 'g');
    const newFields = template.replace(regexp, newId);

    questionsDiv.insertAdjacentHTML('beforeend', newFields);
  });

  questionsDiv.addEventListener('click', (e) => {
    if (e.target.classList.contains('remove-question')) {
      e.target.closest('.nested-fields').remove();
    }
  });
});
